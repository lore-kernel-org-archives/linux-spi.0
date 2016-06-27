From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/3] Updated spidev usability patchset
Date: Mon, 27 Jun 2016 21:02:29 +0200
Message-ID: <cover.1467053363.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This hopefully addresses pretty much all the comments on the previous version.

Thanks

Michal

Michal Suchanek (3):
  spi: spidev: fix the check for spidev in dt
  spi: of: allow instantiating slaves without a driver
  drivers core: allow id match override when manually binding driver

 drivers/base/bus.c   | 25 ++++++++++++++++++++++++-
 drivers/spi/spi.c    |  9 ++++-----
 drivers/spi/spidev.c |  9 +++++++--
 3 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
