From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 10/10] spi: s3c64xx: add device tree support
Date: Wed, 9 May 2012 22:13:28 +0800
Message-ID: <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
	<1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
	<20120509090716.GC28702@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120509090716.GC28702@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 9 May 2012 17:07, Mark Brown <broonie@opensource.wolfsonmicro.com> w=
rote:
> On Wed, May 09, 2012 at 03:34:54AM +0530, Thomas Abraham wrote:
>
>> +- gpios: The gpio specifier for clock, mosi and miso interface line=
s (in no
>> + =A0particular order). The format of the gpio specifier depends on =
the gpio
>> + =A0controller.
>
> This seems odd... =A0This isn't a bitbanging controller, and surely t=
he
> driver will need to know which signal is which? =A0I suspect this is
> actually for pinmux rather than to identify the signals but that shou=
ld
> at least be made clear and really should be being done using the pinm=
ux
> API.

The driver retrieves the list of gpio's that it is allowed to use. The
gpio numbers for miso, mosi and clk are mandatory but the order in
which they are specified is not important since the driver never needs
to which gpio is which interface line. I agree the pinmux api should
be used here, but the call to pinmux api would be a incremental change
here, not changing the code this patch is adding.

>
>> + =A0- samsung,spi-cs-gpio: A gpio specifier that specifies the gpio=
 line used as
>> + =A0 =A0the slave select line by the spi controller. The format of =
the gpio
>> + =A0 =A0specifier depends on the gpio controller.
>
> We should really have a binding for this at the SPI level (and ideall=
y
> some code to manage setting the GPIO too) - it's pretty common to use=
 a
> GPIO as /CS.

The existing implementations vary in the way the nCS gpio lines are
specified. For some controllers, the nCS gpio's are included in the
spi device node whereas in this implementation, the nCS gpio is listed
in the spi slave device node.

Thanks,
Thomas.
