FROM suse/sles12sp2:1.0.0

ARG repo
ARG cert

RUN echo "$cert" > /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT.pem
RUN update-ca-certificates
RUN echo "$repo" > /etc/zypp/repos.d/susemanager:dockerbuild.repo
RUN zypper ref && zypper --non-interactive in apache2
COPY apache2 /etc/sysconfig/
RUN chown -R admin /data
EXPOSE 80
VOLUME /data
ENTRYPOINT ["apache2ctl"]
