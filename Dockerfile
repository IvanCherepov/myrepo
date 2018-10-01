FROM busybox

WORKDIR /app

RUN touch foo
RUN touch bar
RUN date > when
