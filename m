From: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] v1: ARM: sun4i: spi: Allow transfers larger
 than FIFO size
Date: Tue, 18 Mar 2014 15:04:02 -0700 (PDT)
Message-ID: <4636665.0CNduaaJi4@nukelap.gtech>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDGJVA6QWUDRBVEFUOMQKGQEUYDRIHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

These patches are designed to apply on top of sunxi-next. They depend on 
Maxime Ripard's SPI patches for Allwinner A10 (sun4i).

I've watched the bus with a logic analyzer to make sure thing are sane, but 
I'm only able to go up to 10MHz on my LA. Unfortunately, the SPI chip I was 
using as a test device decided to die mid-way, so I was unable to test how 
well full-duplex communication works on these large transfers

Alexandru Gagniuc (2):
  ARM: sun4i: spi: Allow Rx transfers larger than FIFO size
  ARM: sun4i: spi: Allow Tx transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 56 
+++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
1.8.5.3
