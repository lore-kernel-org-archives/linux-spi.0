From: Thomas Behan <thomas.behan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] spi: omap-100k: Style Fixes
Date: Wed, 27 Nov 2013 23:27:20 -0500
Message-ID: <1385612844-22482-1-git-send-email-thomas.behan@gmail.com>
Cc: broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Behan <thomas.behan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

First time contributer here submitting some style fixes. 

I watched Greg Kroah-Hartman's youtube video about getting started with
submitting patches and thought I would give it a try. I fixed up some errors
and warnings that checkpatch.pl was giving. All patches are based off of
linux-next.

Any feedback is much appreciated.

Thomas Behan (4):
  spi: omap-100k: Fixed spacing on while loops
  spi: omap-100k: Fixed spacing on -= operators
  spi: omap-100k: Fixed spacing on commas
  spi: omap-100k: Fixed style of sizeof operators

 drivers/spi/spi-omap-100k.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
