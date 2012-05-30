From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
Date: Wed, 30 May 2012 15:47:26 +0800
Message-ID: <CAJuYYwQ-9hUxhrJpGwd6CvcEbwu_DbKt5+PvgExn4i2Rcw+yJA@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
	<1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
	<20120520092113.GA20652@opensource.wolfsonmicro.com>
	<CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Olof Johansson <olof@lixom.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 30 May 2012 15:28, Olof Johansson <olof@lixom.net> wrote:
> On Sun, May 20, 2012 at 2:21 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Fri, May 18, 2012 at 03:03:31PM +0530, Thomas Abraham wrote:
>>
>>> - =A0 =A0 s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
>>> + =A0 =A0 s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);
>>
>> ...
>>
>>> + =A0 =A0 pd.src_clk_nr =3D src_clk_nr;
>>> + =A0 =A0 pd.cfg_gpio =3D (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_=
gpio;
>>> + =A0 =A0 s3c64xx_device_spi0.name =3D dev_name;
>>
>> This looks *really* strange. =A0Why do we need to pass in a name to =
set in
>> s3c64xx_device_spi0's name, why would we want to use a different nam=
e?
>> This dev_name also isn't equivalent to dev_name() which makes matter=
s
>> more confusing than they need to be.
>>
>> There was similar code for the I2C controllers which caused some rea=
lly
>> hard to debug brittleness.
>
> Looks like they use the name as the magic string to pick initializati=
on data.
>
> I wonder if it makes more sense to keep the platform_data still
> around, and just fill it in with the table (from patch "spi: s3c64xx:
> move controller information into driver data") based on the OF
> compatible field for the device-tree probe case, instead of trying to
> overload and having to change the name in this way.

Ok. Thanks for your suggestion. So for now, the spi controller
configuration data will be left in platform data for non-dt platforms
and allow dt-platforms to have this data as part of the driver (and
picked up based on the compatible value).

Thanks,
Thomas.

>
>
> -Olof
