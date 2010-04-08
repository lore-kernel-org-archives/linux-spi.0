From: <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add support for
	dma_min_bytes configuration.
Date: Thu, 8 Apr 2010 17:25:23 +0200
Message-ID: <E1C7579D1379824DAE67858071C8103828208BC539@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
	<z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC339@NOK-EUMSG-02.mgdnok.nokia.com>
	<s2vfa686aa41004080808o443dd6b7ge4d23c513a1f80a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <s2vfa686aa41004080808o443dd6b7ge4d23c513a1f80a8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

 =

The others from wlan team need DMA_MIN_BYTES to be adjustable.
Juuso can comment this.

Just changing DMA_MIN_BYTES might influence on other spi devices =

controlled by omap2/3 spi controller driver.

Roman

>-----Original Message-----
>From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On =

>Behalf Of ext Grant Likely
>Sent: 08 April, 2010 18:09
>To: Tereshonkov Roman (Nokia-D/Helsinki)
>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Samuel Ortiz
>Subject: Re: [PATCH 1/2] spi: Add support for dma_min_bytes =

>configuration.
>
>On Thu, Apr 8, 2010 at 4:33 AM,  <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>>
>> Hi,
>>
>>
>>>-----Original Message-----
>>>From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On
>>>Behalf Of ext Grant Likely
>>>Sent: 08 April, 2010 09:27
>>>To: Tereshonkov Roman (Nokia-D/Helsinki)
>>>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>Subject: Re: [PATCH 1/2] spi: Add support for dma_min_bytes
>>>configuration.
>>>
>>>Hi Roman,
>>>
>>>On Tue, Apr 6, 2010 at 4:39 AM, Roman Tereshonkov
>>><roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>>>> This parameters defines the minimum number of bytes when =

>dma is used.
>>>>
>>>> Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>>
>>>The intent of this feature is... ? =A0Your patch needs a better
>>>description as to why it is needed; especially considering that it
>>>changes common code.
>>>
>>>But, inferring from the code that is written, I can guess what you're
>>>trying to do, if not why. =A0Why would spi_devices care what =

>the minimum
>>>size of a DMA transfer is? =A0The SPI bus driver is in a far better
>>>position to make that determination.
>>>
>>>Also, since this essentially adds a new 'knob' for spi_devices to
>>>twiddle, what is the expected behaviour for SPI bus controllers that
>>>don't support it? =A0Is it a required feature for spi bus drivers to
>>>implement if they support DMA?
>>
>> The spi transactions can be handled in two ways: dma and pio.
>> For the best perfomance the minimun number of bytes when dma is used
>> can be found experimentaly and passed through the platform =

>board config files.
>>
>> Now I will talk about omap2/3 spi only.
>> If the mentioned parameter is not set then the static default one
>> is used (as it is nowdays).
>> This exludes the patch influence on other spi devices controlled
>> by the same omap2/3 spi master.
>>
>> I think you might be right. The better way would be to pass it
>> through the controller_data field of the spi_board_info.
>> Then I do not need to touch spi.h and spi.c.
>
>The question that must be asked, will this new optimization option
>actually be profiled for most boards?  Should it really be a
>board-specific parameter?  Or even an SoC specific parameter?  Or to
>be even more specific, do *you* have two different boards that need a
>different value for the minimum dma bytes?
>
>If the answer is no, then I recommend profiling your platform and
>floating out a patch that changes the default value to what you find
>is best.  If there is no opposition to the value you choose, then
>there is no need to make it a tunable until someone else comes along
>who needs it to be something different.
>
>The current value of DMA_MIN_BYTES hasn't changed since the driver was
>first submitted.  I suspect that it has not been optimized.  What does
>Samuel have to say about it?
>
>g.
>
>>
>> I will create a new patch.
>> But now I wonder about patches syncronization.
>> The first patch should go to linux-omap tree as it is for =

>arch/arm/plat-omap/include/plat/mcspi.h.
>> The second patch applied after the first one is for =

>driver/spi/omap2_mcspi.h.
>> Or can you handle both patches?
>>
>>
>> Regards
>> Roman
>
---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
