From: jason <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable
 chan between each SPI transfer
Date: Wed, 14 Jul 2010 07:48:03 +0800
Message-ID: <4C3CFB33.3090301@gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C289CCB.7010409@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD84963BC@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C2C82E9.2010103@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C3C6971.5010004@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD8772AB3@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1C7579D1379824DAE67858071C810382DD8772AB3-xJW1crHCIS+8kqYwC468Frtp2NbXvJi8gfoxzgwHRXE@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org wrote:
> Hi,
>
> I tried to find the board with the same touchscreen but failed.
>
> Your patch solves the problem but does not fix the bug.
> It would be nice if you find the roots of the bug to exclude future headackes.
>  
>
> I am leaving to vacation and will be silent some time.
>
>
> Regards
> Roman Tereshonkov
>
>   
OK, Thanks, If possible, i will ask for help from IC designers to 
explain it.

Thanks,
Jason.
>   
>> -----Original Message-----
>> From: ext jason [mailto:jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
>> Sent: 13 July, 2010 16:26
>> To: Tereshonkov Roman (Nokia-MS/Helsinki)
>> Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; 
>> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>> between each SPI transfer
>>
>> Hi roman,
>>
>> How about my test case, does it expose the real problem?
>>
>> I know my original patch was a big change both for PIO mode and for
>> DMA mode, because there is no DMA mode device on my platform and
>> i can't validate whether DMA mode works fine with that patch, 
>> it is a bit
>> risky to apply that patch to upstream.
>>
>> This time i limit my patch to PIO mode, In theory, it is safe for all 
>> PIO transfers.
>> The side effect is to add a little bit overhead for a sequence of 
>> TX_ONLY transfers.
>> But it really can solve my touch panel issue.
>>
>> Is the following patch acceptable?
>>
>> From 7b310e690fcccff400233a4c3340f42168016c92 Mon Sep 17 00:00:00 2001
>> From: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Date: Tue, 13 Jul 2010 18:05:59 +0800
>> Subject: [PATCH] spi/omap2_mcspi: disable channel after 
>> TX_ONLY transfer 
>> in PIO mode
>>
>> In TX_ONLY transfer, the spi controller will receive datas
>> simultaneously and hold them in the rx register, these datas will
>> affect the direct following RX_ONLY transfer. So add disable channel
>> to purge those rx datas.
>>
>> Signed-off-by: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> drivers/spi/omap2_mcspi.c | 6 ++++++
>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..43fab41 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -644,6 +644,12 @@ omap2_mcspi_txrx_pio(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> } else if (mcspi_wait_for_reg_bit(chstat_reg,
>> OMAP2_MCSPI_CHSTAT_EOT) < 0)
>> dev_err(&spi->dev, "EOT timed out\n");
>> +
>> + /* disable chan to purge rx datas received in TX_ONLY transfer,
>> + * otherwise these rx datas will affect the direct following
>> + * RX_ONLY transfer.
>> + */
>> + omap2_mcspi_set_enable(spi, 0);
>> }
>> out:
>> omap2_mcspi_set_enable(spi, 1);
>> -- 
>> 1.5.6.5
>>
>>
>>
>> roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org wrote:
>>     
>>> Hi Jason,
>>>
>>> Your logs do not show what I wanted to see.
>>> But what I can see now at least is the case when TX is full 
>>>       
>> and RX is full at the same time.
>>     
>>> 1.  Put 
>>> 	dev_dbg(&spi->dev, "status reg: %08x\n", 
>>>       
>> __raw_readl(chstat_reg));
>>     
>>> 	after "do" and before "while (c)" in 
>>>       
>> omap2_mcspi_txrx_pio function.
>>     
>>> 	I want to see how status is changed before and after TX 
>>>       
>> or RX transaction.
>>     
>>> 2. Also try to make fake reading 
>>> 	__raw_readl(tx_reg)
>>> 	 after TX write in omap2_mcspi_txrx_pio.
>>> 	and 
>>> 	__raw_readl(cs->base + OMAP2_MCSPI_TX0);
>>> 	in mcspi_work function.
>>> 	This should exclude the posted write effect if such present.
>>>
>>> If you put more logging info from other spi registers it 
>>>       
>> might be also usefull in problem analyzing.
>>     
>>> And it is better to concentrate on your test case 1. 
>>> So as it is the test which gives the bug with unknown yet nature.
>>>
>>>
>>>
>>> Regards
>>> Roman Tereshonkov
>>>
>>>   
>>>       
>>>> -----Original Message-----
>>>> From: ext jason [mailto:jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
>>>> Sent: 01 July, 2010 14:59
>>>> To: Tereshonkov Roman (Nokia-MS/Helsinki)
>>>> Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; 
>>>> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
>>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>> Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>>>> between each SPI transfer
>>>>
>>>> roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org wrote:
>>>>     
>>>>         
>>>>> Hi Jason,
>>>>>
>>>>> It is a little bit hard to analyze your logs.
>>>>> 1. You showed the bytes read in your own way but there is 
>>>>>       
>>>>>           
>>>> the data reading in omap2_mcspi_txrx_pio function also.
>>>>     
>>>>         
>>>>> 2. For your third test case. You try to read data after 
>>>>>       
>>>>>           
>>>> TX_ONLY, before triggering RX_ONLY, and get the right word.
>>>>     
>>>>         
>>>>> Looks like there is something wrong.
>>>>>
>>>>> Try to log MCSPI_CHxSTAT register to follow when RXS bit 
>>>>>       
>>>>>           
>>>> (register RX is full) is set.
>>>>     
>>>>         
>>>>> And do not use the RX register reading in you own way. If 
>>>>>       
>>>>>           
>>>> you need RX logging do it from omap2_mcspi_txrx_pio function.
>>>>     
>>>>         
>>>>>       
>>>>>           
>> <snip>
>>
>>
>>     


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
