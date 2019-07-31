# Galaxy - NGS

FROM bgruening/galaxy-stable:19.01

MAINTAINER Vesselin Baev, vebaev@plantgene.eu

# Enable Conda dependency resolution
ENV GALAXY_CONFIG_BRAND="Galaxy NGS" \
    GALAXY_CONFIG_CONDA_AUTO_INSTALL=True

# Install tools
COPY NGS_1.yaml $GALAXY_ROOT/tools_1.yaml
COPY NGS_2.yaml $GALAXY_ROOT/tools_2.yaml

# Split into multiple layers
RUN install-tools $GALAXY_ROOT/tools_1.yaml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf

RUN install-tools $GALAXY_ROOT/tools_2.yaml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf


# Add Container Style
ENV GALAXY_CONFIG_WELCOME_URL=$GALAXY_CONFIG_DIR/web/welcome.html
COPY config/welcome.html $GALAXY_CONFIG_DIR/web/welcome.html
COPY config/welcome_NGS.png $GALAXY_CONFIG_DIR/web/welcome_NGS.png


# Add Multi CPU job_conf file (--ntasks=16)
#ENV GALAXY_CONFIG_JOB_CONFIG_FILE=$GALAXY_CONFIG_DIR/job_conf.xml
#COPY config/job_conf.xml $GALAXY_CONFIG_DIR/job_conf.xml
