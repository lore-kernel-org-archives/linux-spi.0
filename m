From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
Date: Wed, 30 May 2012 00:28:55 -0700
Message-ID: <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
	<1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
	<20120520092113.GA20652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Abraham <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120520092113.GA20652@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, May 20, 2012 at 2:21 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 18, 2012 at 03:03:31PM +0530, Thomas Abraham wrote:
>
>> - =A0 =A0 s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
>> + =A0 =A0 s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);
>
> ...
>
>> + =A0 =A0 pd.src_clk_nr =3D src_clk_nr;
>> + =A0 =A0 pd.cfg_gpio =3D (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_g=
pio;
>> + =A0 =A0 s3c64xx_device_spi0.name =3D dev_name;
>
> This looks *really* strange. =A0Why do we need to pass in a name to s=
et in
> s3c64xx_device_spi0's name, why would we want to use a different name=
?
> This dev_name also isn't equivalent to dev_name() which makes matters
> more confusing than they need to be.
>
> There was similar code for the I2C controllers which caused some real=
ly
> hard to debug brittleness.

Looks like they use the name as the magic string to pick initialization=
 data.

I wonder if it makes more sense to keep the platform_data still
around, and just fill it in with the table (from patch "spi: s3c64xx:
move controller information into driver data") based on the OF
compatible field for the device-tree probe case, instead of trying to
overload and having to change the name in this way.


-Olof
