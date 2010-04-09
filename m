From: <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add support for
	dma_min_bytes configuration.
Date: Fri, 9 Apr 2010 10:38:56 +0200
Message-ID: <E1C7579D1379824DAE67858071C8103828208BC96F@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
	<z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC339@NOK-EUMSG-02.mgdnok.nokia.com>
	<s2vfa686aa41004080808o443dd6b7ge4d23c513a1f80a8@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC539@NOK-EUMSG-02.mgdnok.nokia.com>
	<1270785939.10120.1141.camel@wimaxnb.nmp.nokia.com>
	<E1C7579D1379824DAE67858071C8103828208BC90A@NOK-EUMSG-02.mgdnok.nokia.com>
	<1270799541.10120.1146.camel@wimaxnb.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org
To: <juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1270799541.10120.1146.camel-gZysiALljqf+W+uuys5jPoH6Mc4MB0Vx@public.gmane.org>
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

 

>-----Original Message-----
>From: Oikarinen Juuso (Nokia-D/Tampere) 
>Sent: 09 April, 2010 10:52
>To: Tereshonkov Roman (Nokia-D/Helsinki)
>Cc: ext Grant Likely; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
>Samuel Ortiz
>Subject: RE: [PATCH 1/2] spi: Add support for dma_min_bytes 
>configuration.
>
>On Fri, 2010-04-09 at 09:49 +0200, Tereshonkov Roman (Nokia-D/Helsinki)
>wrote:
>> 
>> >-----Original Message-----
>> >From: Oikarinen Juuso (Nokia-D/Tampere) 
>> >Sent: 09 April, 2010 07:06
>> >To: Tereshonkov Roman (Nokia-D/Helsinki)
>> >Cc: ext Grant Likely; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
>> >Samuel Ortiz
>> >Subject: RE: [PATCH 1/2] spi: Add support for dma_min_bytes 
>> >configuration.
>> >
>> >Hi,
>> >
>> >The wl1271 driver does not actually require this value to 
>be adjustable
>> >- i.e. the driver does not need to know the value. In fact, 
>the wl1271
>> >does not know about DMA at all, instead the SPI controller 
>driver makes
>> >the choice on how to perform the transfer most optimally.
>> >
>> >So we - or the wl1271 driver - just need the selection 
>between DMA and
>> >PIO to be optimal in point of view of throughput and CPU 
>load. The old
>> >threshold value of 8 is far from optimal - something like 
>160-200 is in
>> >the correct range.
>> >
>> >AFAIK performing the SPI transfer optimally should not 
>affect other SPI
>> >clients in a negative way, and AFAIK there are no other SPI 
>clients in
>> >Dali than the wl1271, so I guess this new threshold value 
>could also be
>> >hard-coded into the omap2_mcspi driver.
>> 
>> 
>> 
>> What about omap2 based projects which use the same driver?
>> 
>
>The threshold, I think, is ultimately something that depends 
>on how long
>it takes to arm DMA. The longer it takes to do that, the larger the
>optimal threshold.
>
>Is it conceivable, that the time it takes to arm the DMA in those
>potential platforms varies? If it does, the threshold should be
>configurable.

There are wl1251 and wl1271 spi clients in omap3. And there are two 
omap2 spi clients, touchscreen ads7846 and wlan p54spi, found in 
arch/arm/mach-omap2. All of them use now the default DMA_MIN_BYTES 
set to 8. When we change this value for our needs it might influence 
also on all of them.

Having the same spi clock but different cpu clock for omap2 and omap3 
I suspect that optimal DMA_MIN_VALUE found for omap3 
will be different for omap2.

Roman

>
>-Juuso
>
>> 
>> 
>> Roman
>> 
>> 
>> >
>> >-Juuso
>> >
>> >On Thu, 2010-04-08 at 17:25 +0200, Tereshonkov Roman 
>(Nokia-D/Helsinki)
>> >wrote:
>> >> The others from wlan team need DMA_MIN_BYTES to be adjustable.
>> >> Juuso can comment this.
>> >> 
>> >> Just changing DMA_MIN_BYTES might influence on other spi devices 
>> >> controlled by omap2/3 spi controller driver.
>> >> 
>> >> Roman
>> >> 
>> >> >-----Original Message-----
>> >> >From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On 
>> >> >Behalf Of ext Grant Likely
>> >> >Sent: 08 April, 2010 18:09
>> >> >To: Tereshonkov Roman (Nokia-D/Helsinki)
>> >> >Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Samuel Ortiz
>> >> >Subject: Re: [PATCH 1/2] spi: Add support for dma_min_bytes 
>> >> >configuration.
>> >> >
>> >> >On Thu, Apr 8, 2010 at 4:33 AM,  
>> ><roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>> >> >>
>> >> >> Hi,
>> >> >>
>> >> >>
>> >> >>>-----Original Message-----
>> >> >>>From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On
>> >> >>>Behalf Of ext Grant Likely
>> >> >>>Sent: 08 April, 2010 09:27
>> >> >>>To: Tereshonkov Roman (Nokia-D/Helsinki)
>> >> >>>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> >> >>>Subject: Re: [PATCH 1/2] spi: Add support for dma_min_bytes
>> >> >>>configuration.
>> >> >>>
>> >> >>>Hi Roman,
>> >> >>>
>> >> >>>On Tue, Apr 6, 2010 at 4:39 AM, Roman Tereshonkov
>> >> >>><roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>> >> >>>> This parameters defines the minimum number of bytes when 
>> >> >dma is used.
>> >> >>>>
>> >> >>>> Signed-off-by: Roman Tereshonkov 
><roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> >> >>>
>> >> >>>The intent of this feature is... ?  Your patch needs a better
>> >> >>>description as to why it is needed; especially 
>considering that it
>> >> >>>changes common code.
>> >> >>>
>> >> >>>But, inferring from the code that is written, I can guess 
>> >what you're
>> >> >>>trying to do, if not why.  Why would spi_devices care what 
>> >> >the minimum
>> >> >>>size of a DMA transfer is?  The SPI bus driver is in a 
>far better
>> >> >>>position to make that determination.
>> >> >>>
>> >> >>>Also, since this essentially adds a new 'knob' for 
>spi_devices to
>> >> >>>twiddle, what is the expected behaviour for SPI bus 
>> >controllers that
>> >> >>>don't support it?  Is it a required feature for spi 
>bus drivers to
>> >> >>>implement if they support DMA?
>> >> >>
>> >> >> The spi transactions can be handled in two ways: dma and pio.
>> >> >> For the best perfomance the minimun number of bytes when 
>> >dma is used
>> >> >> can be found experimentaly and passed through the platform 
>> >> >board config files.
>> >> >>
>> >> >> Now I will talk about omap2/3 spi only.
>> >> >> If the mentioned parameter is not set then the static 
>default one
>> >> >> is used (as it is nowdays).
>> >> >> This exludes the patch influence on other spi devices 
>controlled
>> >> >> by the same omap2/3 spi master.
>> >> >>
>> >> >> I think you might be right. The better way would be to pass it
>> >> >> through the controller_data field of the spi_board_info.
>> >> >> Then I do not need to touch spi.h and spi.c.
>> >> >
>> >> >The question that must be asked, will this new 
>optimization option
>> >> >actually be profiled for most boards?  Should it really be a
>> >> >board-specific parameter?  Or even an SoC specific 
>parameter?  Or to
>> >> >be even more specific, do *you* have two different boards 
>> >that need a
>> >> >different value for the minimum dma bytes?
>> >> >
>> >> >If the answer is no, then I recommend profiling your platform and
>> >> >floating out a patch that changes the default value to 
>what you find
>> >> >is best.  If there is no opposition to the value you choose, then
>> >> >there is no need to make it a tunable until someone else 
>comes along
>> >> >who needs it to be something different.
>> >> >
>> >> >The current value of DMA_MIN_BYTES hasn't changed since the 
>> >driver was
>> >> >first submitted.  I suspect that it has not been optimized. 
>> > What does
>> >> >Samuel have to say about it?
>> >> >
>> >> >g.
>> >> >
>> >> >>
>> >> >> I will create a new patch.
>> >> >> But now I wonder about patches syncronization.
>> >> >> The first patch should go to linux-omap tree as it is for 
>> >> >arch/arm/plat-omap/include/plat/mcspi.h.
>> >> >> The second patch applied after the first one is for 
>> >> >driver/spi/omap2_mcspi.h.
>> >> >> Or can you handle both patches?
>> >> >>
>> >> >>
>> >> >> Regards
>> >> >> Roman
>> >> >
>> >
>> >
>> >
>
>
>
------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
