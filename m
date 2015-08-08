From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: [PATCH v6] ARM: sun4i: spi: Allow transfers larger than
 FIFO size
Date: Sat,  8 Aug 2015 21:41:51 +0200
Message-ID: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
Reply-To: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>,
	dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBCNXTGXAKGQE6JRADII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Alexandru sent this patch over a year and a half ago, and I believe several
tree's have been carrying it since. We've been using this patch on an
Olimex OLinuxIno Lime1 and Lime2 using the mmc-spi driver to access SD cards
without problems. So bumping this and adding my

Tested-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

Changes from v5as warned by checkpatch. No functional changes.
 * Added some newlines to make checkpatch happy. No functional changes.

Changes from v4:
 * use min3() instead of two if statements in sun4i_spi_fill_fifo()
 * fix trivial whitespace issue in if statement in sun4i_spi_handler()
 * use consistent style in assigning 'reg' in the added functions.

Alexandru Gagniuc (1):
  ARM: sun4i: spi: Allow transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 76 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 9 deletions(-)

-- 
2.1.4
