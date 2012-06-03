From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
Date: Sun, 3 Jun 2012 14:59:50 +0530
Message-ID: <CAJuYYwS6xgTQD=azEc_020fBCvEzpu5bF6ANvnu1_iZfGptP-Q@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
	<1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
	<20120520092113.GA20652@opensource.wolfsonmicro.com>
	<CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
	<20120530093421.GA9947@opensource.wolfsonmicro.com>
	<CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
	<20120530101326.GF9947@opensource.wolfsonmicro.com>
	<CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
	<20120531113659.GB2666@opensource.wolfsonmicro.com>
	<CAJuYYwS5vPO9GNFMGArroOe57Z80+gP0vnRMjPuXRaxukNJ8uw@mail.gmail.com>
	<20120601123902.GL24139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olof Johansson <olof@lixom.net>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120601123902.GL24139@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1 June 2012 18:09, Mark Brown <broonie@opensource.wolfsonmicro.com> =
wrote:
> On Fri, Jun 01, 2012 at 10:47:44AM +0800, Thomas Abraham wrote:
>
>> 1. There is one instance of 'struct platform_device' for each of the
>> spi controller instances (0/1/2) named "s3c64xx-spi" (in
>> arch/arm/plat-samsung/devs.c).
>
> Right, which looks rather like it is specific to s3c64xx at least giv=
en
> the naming... =A0there aren't any current in tree users, though I do =
have
> one out of tree user on s3c6410. =A0If this is supposed to be used on=
 the
> later SoCs too then I guess it ought to be renamed anyway since what'=
s
> there looks wrong.

The spi platform device is not really s3c64xx specific. It can be
reused on all other Samsung SoC's as well, but there are no users of
this except for s3c64xx SoC. The resources for this platform devices
are statically bound for a SoC during compile time. I would not
consider the existing spi platform device instance name
(s3c64xx_device_spi0) or the .name (s3c64xx-spi) to be factor in
reusing it on other Samsung SoC's.

>
>> 5. If point 4 is not correct, the other option is to create a separa=
te
>> instances of 'struct platform_device' for each of the s3c, s5p and
>> Exynos4/5 SoC's. Is this the correct way, and if yes, could you plea=
se
>> help me understand the issues in setting the name of the platform
>> device at runtime.
>
> That would seem less painful to me. =A0The big problem I've found is =
with
> things like matching clocks up where if you look at the device that's
> being registered it has one name but at runtime it has another name, =
it
> makes everything much harder to follow. =A0There was one of the devic=
es
> where the .id also ended up getting changed which created even more
> confusion.

Yes, I agree with you that changing device names at runtime can be
confusing at times. Probably, additional comments to indicate possible
runtime changes in device names could be useful.

=46or now, I will avoid runtime setting of platform device name as you
have suggested. Thank your for providing clarification for my
questions.

Regards,
Thomas.
