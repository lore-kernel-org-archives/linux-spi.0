From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add support for
	dma_min_bytes configuration.
Date: Fri, 9 Apr 2010 08:52:56 -0600
Message-ID: <i2yfa686aa41004090752u24b60033zcc9baf9ea1a3aeac@mail.gmail.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
	<z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC339@NOK-EUMSG-02.mgdnok.nokia.com>
	<s2vfa686aa41004080808o443dd6b7ge4d23c513a1f80a8@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC539@NOK-EUMSG-02.mgdnok.nokia.com>
	<1270785939.10120.1141.camel@wimaxnb.nmp.nokia.com>
	<E1C7579D1379824DAE67858071C8103828208BC90A@NOK-EUMSG-02.mgdnok.nokia.com>
	<1270799541.10120.1146.camel@wimaxnb.nmp.nokia.com>
	<E1C7579D1379824DAE67858071C8103828208BC96F@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org
To: roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1C7579D1379824DAE67858071C8103828208BC96F-xJW1crHCIS+8kqYwC468Frtp2NbXvJi8gfoxzgwHRXE@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 9, 2010 at 2:38 AM,  <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>
>
>>-----Original Message-----
>>From: Oikarinen Juuso (Nokia-D/Tampere)
>>Sent: 09 April, 2010 10:52
>>To: Tereshonkov Roman (Nokia-D/Helsinki)
>>Cc: ext Grant Likely; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;
>>Samuel Ortiz
>>Subject: RE: [PATCH 1/2] spi: Add support for dma_min_bytes
>>configuration.
>>
>>On Fri, 2010-04-09 at 09:49 +0200, Tereshonkov Roman (Nokia-D/Helsinki)
>>wrote:
>>>
>>> >-----Original Message-----
>>> >From: Oikarinen Juuso (Nokia-D/Tampere)
>>> >Sent: 09 April, 2010 07:06
>>> >To: Tereshonkov Roman (Nokia-D/Helsinki)
>>> >Cc: ext Grant Likely; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;
>>> >Samuel Ortiz
>>> >Subject: RE: [PATCH 1/2] spi: Add support for dma_min_bytes
>>> >configuration.
>>> >
>>> >Hi,
>>> >
>>> >The wl1271 driver does not actually require this value to
>>be adjustable
>>> >- i.e. the driver does not need to know the value. In fact,
>>the wl1271
>>> >does not know about DMA at all, instead the SPI controller
>>driver makes
>>> >the choice on how to perform the transfer most optimally.
>>> >
>>> >So we - or the wl1271 driver - just need the selection
>>between DMA and
>>> >PIO to be optimal in point of view of throughput and CPU
>>load. The old
>>> >threshold value of 8 is far from optimal - something like
>>160-200 is in
>>> >the correct range.
>>> >
>>> >AFAIK performing the SPI transfer optimally should not
>>affect other SPI
>>> >clients in a negative way, and AFAIK there are no other SPI
>>clients in
>>> >Dali than the wl1271, so I guess this new threshold value
>>could also be
>>> >hard-coded into the omap2_mcspi driver.
>>>
>>>
>>>
>>> What about omap2 based projects which use the same driver?
>>>
>>
>>The threshold, I think, is ultimately something that depends
>>on how long
>>it takes to arm DMA. The longer it takes to do that, the larger the
>>optimal threshold.
>>
>>Is it conceivable, that the time it takes to arm the DMA in those
>>potential platforms varies? If it does, the threshold should be
>>configurable.
>
> There are wl1251 and wl1271 spi clients in omap3. And there are two
> omap2 spi clients, touchscreen ads7846 and wlan p54spi, found in
> arch/arm/mach-omap2. All of them use now the default DMA_MIN_BYTES
> set to 8. When we change this value for our needs it might influence
> also on all of them.

Yup.  Change the default, post the patch, and solicit omap2 users for feedback.

> Having the same spi clock but different cpu clock for omap2 and omap3
> I suspect that optimal DMA_MIN_VALUE found for omap3
> will be different for omap2.

Most likely, but I would hold off merging a new tunable parameter
until someone actually takes on the work of tuning for omap2 vs.
omap3.  No sense adding a dynamic tunable if it never gets used.

g.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
