From: Shobhit Srivastava <shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] Enable SSP controller for CS toggle
Date: Tue, 18 Feb 2020 19:19:05 +0530
Message-ID: <20200218134906.25458-1-shobhit.srivastava@intel.com>
Cc: furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        robert.jarzmik-GANU6spQydw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


SPI CS assert may not always be accompanied by data. There are cases
where we want to assert CS, wait and then deassert CS. There is no
clocking or reading required. On Intel CNL LPSS controller, it was
observed that the above flow is broken after an S0ix cycle. There
is no issue after S3 flow.
https://patchwork.kernel.org/patch/11377019/ is an attempt to fix
this and it does fix the issue. However we are unsure if that is
the actual rootcause for the issue. As per the LPSS spec, to
propagate the retained CS to output,  SPI controller needs to be
enabled. The below patch tries to do the same and it fixes the issue.
The reason why there is no issue after S3 flow is because during
resume, BIOS re-initializes and enables SPI before doing kernel hand-off.
To test this issue we are probing the SPI_CS line on CRO. This is
because, even though the mmio writes to CS_CONTROL register sticks,
it doesnt toggle the CS line. Physically probing is the best way
to identify the fix.


Shobhit Srivastava (1):
  spi: pxa2xx: Enable SSP controller for CS toggle

 drivers/spi/spi-pxa2xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.17.1
