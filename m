From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
	s3c64xx_spi{0|1|2}_set_platdata function
Date: Thu, 31 May 2012 10:05:42 +0800
Message-ID: <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
	<1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
	<20120520092113.GA20652@opensource.wolfsonmicro.com>
	<CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
	<20120530093421.GA9947@opensource.wolfsonmicro.com>
	<CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
	<20120530101326.GF9947@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120530101326.GF9947-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 30 May 2012 18:13, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrot=
e:
> On Wed, May 30, 2012 at 06:05:31PM +0800, Thomas Abraham wrote:
>> On 30 May 2012 17:34, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> w=
rote:
>
>> > Right, and there's no problem at all with using the name. =A0The thing=
 is
>> > that there's no need to set the name at runtime since the struct device
>> > being configured is always going to end up with the same name and doing
>> > so is just causing confusion. =A0The device being registered is specif=
ic
>> > to the SoC already so setting the SoC name at runtime isn't needed.
>
>> I think I did not understand your point. There is only one instance of
>> spi platform device statically defined for all Samsung platforms. The
>
> No there isn't. =A0You've got things like s3c64xx_device_spi0 in
> arch/arm/plat-samsung/devs.c (which you'd expect since the resources
> that are passed in for memory mapping, DMA and interrupt vary with the
> SoC). =A0The bit of code I was querying just changes "s3c64xx-spi" to
> "s3c6410-spi" at runtime in that structure which seems like a waste of
> time.

So is the concern only with the change of device name from
"s3c64xx-spi" to "s3c6410-spi"? Is there any concern with changing the
name of the static spi platform device (s3c64xx_device_spi0/1/2) at
runtime which then is used to select a driver data?

Thanks,
Thomas.

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
