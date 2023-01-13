FROM phidata/python:3.9.12

ARG USER=backend
ARG HOME_DIR=${USER_LOCAL_DIR}/${USER}
ENV HOME_DIR=${HOME_DIR}

# Create user and home directory
RUN groupadd -g 61000 ${USER} \
  && useradd -g 61000 -u 61000 -ms /bin/bash -d ${HOME_DIR} ${USER}

COPY . ${HOME_DIR}
# Install pinned requirements
RUN pip install -r ${HOME_DIR}/requirements.txt
# Install package for the `app` cli
RUN pip install ${HOME_DIR}

USER ${USER}
WORKDIR ${HOME_DIR}

COPY scripts /scripts
ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["chill"]
