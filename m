From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Fri, 1 Jun 2012 10:47:44 +0800
Message-ID: <CAJuYYwS5vPO9GNFMGArroOe57Z80+gP0vnRMjPuXRaxukNJ8uw@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
 <20120530101326.GF9947@opensource.wolfsonmicro.com>
 <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
 <20120531113659.GB2666@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120531113659.GB2666-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 31 May 2012 19:36, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrot=
e:
> On Thu, May 31, 2012 at 10:05:42AM +0800, Thomas Abraham wrote:
>> On 30 May 2012 18:13, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> w=
rote:
>
>> > No there isn't. =A0You've got things like s3c64xx_device_spi0 in
>> > arch/arm/plat-samsung/devs.c (which you'd expect since the resources
>> > that are passed in for memory mapping, DMA and interrupt vary with the
>> > SoC). =A0The bit of code I was querying just changes "s3c64xx-spi" to
>> > "s3c6410-spi" at runtime in that structure which seems like a waste of
>> > time.
>
>> So is the concern only with the change of device name from
>> "s3c64xx-spi" to "s3c6410-spi"? Is there any concern with changing the
>> name of the static spi platform device (s3c64xx_device_spi0/1/2) at
>> runtime which then is used to select a driver data?
>
> No, you're not getting it at all. =A0The changing at runtime is the
> problem, it's achieving nothing except making the code more fragile and
> obscure. =A0Those devices will always come out with exactly the same name
> so we should just assign that name statically.

Yes, I am not able to understand your point. So I am listing out my
understanding of the issue here. Please let me know which of these you
think needs to be changed.

1. There is one instance of 'struct platform_device' for each of the
spi controller instances (0/1/2) named "s3c64xx-spi" (in
arch/arm/plat-samsung/devs.c).

2. These instances of platform device is then statically assigned the
resources (mem/irq/dma) based on the SoC for which it is being
compiled (IRQ_SPI0, S3C_PA_SPI0, DMACH_SPI0_TX and DMACH_SPI0_RX).
These macros have different values for different SoC's.

3. Board files based on Samsung SoC's includes the static 'struct
platform_device' for spi in the list of platform devices that are
registered. Which means, the spi platform device is registered with
the name "s3c64xx-spi" for all s3c, s5p and Exynos series SoC's.

4. So, in order to use a "struct platform_device_id" table in the spi
driver (drivers/spi/spi-s3c64xx.c), the '.name' in spi's "struct
platform_device" is changed at runtime, to indicate the SoC on which
it is being used, and correspondingly, match with one of the entries
in the "struct platform_device_id" table in the driver.

5. If point 4 is not correct, the other option is to create a separate
instances of 'struct platform_device' for each of the s3c, s5p and
Exynos4/5 SoC's. Is this the correct way, and if yes, could you please
help me understand the issues in setting the name of the platform
device at runtime.

Sorry to prolong this for so long, but I want to understand your point on t=
his.

Thanks,
Thomas.
