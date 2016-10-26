From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
Date: Wed, 26 Oct 2016 00:00:30 -0700
Message-ID: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
Cc: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is the seventh attempt to get this patch in. I was prompted to look
into this again as someone recently remarked:

" cool, to bad spi does not work properly on allwinner..."

Two and a half years ago,  we were told this will all be handled with DMA.
A year or so ago, we were told this will all be handled with DMA.
A week or so ago, we were told this will all be handled with DMA.

See the pattern?
When DMA finally takes over, this fallback path is not mutually exclusive.

Changes since V6:
Rebased to make sure it applies on top of 4.9-rc.
Also tested on actual hardware.

Alexandru Gagniuc (1):
  spi: sun4i: Allow transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 75 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 8 deletions(-)

--
2.7.4
