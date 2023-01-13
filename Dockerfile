FROM phidata/python:3.9.12
LABEL maintainer="Ashpreet Bedi <ashpreet@phidata.com>"

ARG USER=assistant
ARG HOME_DIR=${USER_LOCAL_DIR}/${USER}
ENV HOME_DIR=${HOME_DIR}
# Add HOME_DIR to PYTHONPATH
ENV PYTHONPATH="${HOME_DIR}:${PYTHONPATH}"

# Create user and home directory
RUN groupadd -g 61000 ${USER} \
  && useradd -g 61000 -u 61000 -ms /bin/bash -d ${HOME_DIR} ${USER}

COPY . ${HOME_DIR}
# Install pinned requirements
RUN pip install -r ${HOME_DIR}/requirements.txt
# Install package for the `api` cli
RUN pip install ${HOME_DIR}

USER ${USER}
WORKDIR ${HOME_DIR}

COPY scripts /scripts
ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["chill"]
