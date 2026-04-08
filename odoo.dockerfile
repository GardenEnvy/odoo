FROM odoo:18.0

USER root

# Install system dependencies for OCA modules (Geospatial, MIS Builder, etc.)
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    libgeos-dev \
    libproj-dev \
    libgdal-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create directory for custom addons
RUN mkdir -p /mnt/extra-addons

# Clone OCA Repositories (Branch 18.0)
WORKDIR /mnt/extra-addons
RUN git clone --depth 1 --branch 18.0 https://github.com/OCA/field-service.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/sign.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/web.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/website.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/hr.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/geospatial.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/bank-payment.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/knowledge.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/management-system.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/mis-builder.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/connector-telephony.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/automation.git && \
    git clone --depth 1 --branch 18.0 https://github.com/OCA/payroll.git

# Clone Odoo Mates Accounting (Ensure branch is 18.0)
RUN git clone --depth 1 --branch 18.0 https://github.com/odoomates/odooapps.git odoo_mates

# Install Python dependencies for the cloned modules
RUN pip3 install --no-cache-dir \
    shapely \
    geojson \
    pyproj \
    phonenumbers \
    vobject

RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo