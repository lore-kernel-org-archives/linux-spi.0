From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles
Date: Thu, 19 Nov 2015 16:53:41 +0100
Message-ID: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDFO74UEV4IRBDXBW6ZAKGQEHKJESLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi all,

the Allwinner A10/A20 SPI module supports an option to configure a number of
clock periods to wait between each word ("SPI Wait Clock Register" in the A20
manual). This is a very useful option if talking to devices which specify a
minimum amount of inter-word wait time.

I initially tried to find a way to let SPI protocol drivers specify this
option, but I couldn't find a mechanism to pass additional options to the spi
master. So I took the spi-davinci driver as an example (it implements a very
similiar functionality) and added a new devicetree property.

While testing this patch I noticed that the SPI module always adds a constant
3 clock cycles to the number set in the Wait Clock Register. That number stays
constant across many different baud rates, so I documented it in the
devicetree binding file.

One thing I am unsure of is the device example in the binding
documentation.  I used "example,dummy" as compatible... is this acceptable or
should I use a device/compatible that actually exists somewhere?

Oh... and should I split binding documentation and code changing patch?

Best regards,

  Marcus


Marcus Weseloh (1):
  spi: dts: sun4i: Add support for inter-word wait cycles using the SPI
    Wait Clock Register

 Documentation/devicetree/bindings/spi/spi-sun4i.txt | 11 +++++++++++
 drivers/spi/spi-sun4i.c                             |  7 +++++++
 2 files changed, 18 insertions(+)

-- 
1.9.1
