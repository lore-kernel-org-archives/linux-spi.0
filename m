From: <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add support for
	dma_min_bytes configuration.
Date: Thu, 8 Apr 2010 12:33:52 +0200
Message-ID: <E1C7579D1379824DAE67858071C8103828208BC339@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
	<z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Hi,


>-----Original Message-----
>From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On =

>Behalf Of ext Grant Likely
>Sent: 08 April, 2010 09:27
>To: Tereshonkov Roman (Nokia-D/Helsinki)
>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [PATCH 1/2] spi: Add support for dma_min_bytes =

>configuration.
>
>Hi Roman,
>
>On Tue, Apr 6, 2010 at 4:39 AM, Roman Tereshonkov
><roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>> This parameters defines the minimum number of bytes when dma is used.
>>
>> Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>
>The intent of this feature is... ?  Your patch needs a better
>description as to why it is needed; especially considering that it
>changes common code.
>
>But, inferring from the code that is written, I can guess what you're
>trying to do, if not why.  Why would spi_devices care what the minimum
>size of a DMA transfer is?  The SPI bus driver is in a far better
>position to make that determination.
>
>Also, since this essentially adds a new 'knob' for spi_devices to
>twiddle, what is the expected behaviour for SPI bus controllers that
>don't support it?  Is it a required feature for spi bus drivers to
>implement if they support DMA?

The spi transactions can be handled in two ways: dma and pio.
For the best perfomance the minimun number of bytes when dma is used =

can be found experimentaly and passed through the platform board config fil=
es.

Now I will talk about omap2/3 spi only.
If the mentioned parameter is not set then the static default one =

is used (as it is nowdays).
This exludes the patch influence on other spi devices controlled =

by the same omap2/3 spi master.

I think you might be right. The better way would be to pass it =

through the controller_data field of the spi_board_info.
Then I do not need to touch spi.h and spi.c.

I will create a new patch.
But now I wonder about patches syncronization.
The first patch should go to linux-omap tree as it is for arch/arm/plat-oma=
p/include/plat/mcspi.h.
The second patch applied after the first one is for driver/spi/omap2_mcspi.=
h.
Or can you handle both patches?


Regards
Roman
>
>Cheers,
>g.
>
>> ---
>> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0 =A01 +
>> =A0include/linux/spi/spi.h | =A0 =A03 +++
>> =A02 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index b76f246..5bf7992 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -347,6 +347,7 @@ struct spi_device *spi_new_device(struct =

>spi_master *master,
>> =A0 =A0 =A0 =A0proxy->max_speed_hz =3D chip->max_speed_hz;
>> =A0 =A0 =A0 =A0proxy->mode =3D chip->mode;
>> =A0 =A0 =A0 =A0proxy->irq =3D chip->irq;
>> + =A0 =A0 =A0 proxy->dma_min_bytes =3D chip->dma_min_bytes;
>> =A0 =A0 =A0 =A0strlcpy(proxy->modalias, chip->modalias, =

>sizeof(proxy->modalias));
>> =A0 =A0 =A0 =A0proxy->dev.platform_data =3D (void *) chip->platform_data;
>> =A0 =A0 =A0 =A0proxy->controller_data =3D chip->controller_data;
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 97b60b3..4e9961d 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -84,6 +84,7 @@ struct spi_device {
>> =A0#define =A0 =A0 =A0 =A0SPI_NO_CS =A0 =A0 =A0 0x40 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* 1 =

>dev/bus, no chipselect */
>> =A0#define =A0 =A0 =A0 =A0SPI_READY =A0 =A0 =A0 0x80 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* =

>slave pulls low to pause */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_wo=
rd;
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_min_bytes;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*controller_s=
tate;
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*controller_d=
ata;
>> @@ -727,6 +728,8 @@ struct spi_board_info {
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode;
>>
>> + =A0 =A0 =A0 /* dma_min_bytes defines minimum bytes when dma is used */
>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 dma_min_bytes;
>> =A0 =A0 =A0 =A0/* ... may need additional spi_device chip config data he=
re.
>> =A0 =A0 =A0 =A0 * avoid stuff protocol drivers can set; but include stuff
>> =A0 =A0 =A0 =A0 * needed to behave without being bound to a driver:
>> --
>> 1.6.2.rc1.3.g81d3f
>>
>>
>
>
>
>-- =

>Grant Likely, B.Sc., P.Eng.
>Secret Lab Technologies Ltd.
>
---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
