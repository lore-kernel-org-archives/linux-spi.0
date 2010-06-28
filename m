From: <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable
 chan between each SPI transfer
Date: Mon, 28 Jun 2010 11:12:39 +0200
Message-ID: <E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4C24A182.4060009-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
>From: ext jason [mailto:jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
>Sent: 25 June, 2010 15:31
>To: Grant Likely
>Cc: Tereshonkov Roman (Nokia-D/Helsinki); david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; 
>spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>between each SPI transfer
>
>Grant Likely wrote:
>> On Thu, Jun 24, 2010 at 6:12 AM, Jason Wang 
><jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>   
>>> In current design, the SPI channel is always enable during 
>the period
>>> of handling a SPI message, it is risky when more than one 
>SPI transfer
>>> are included in a message. Current working route like that:
>>> [
>>>  SPI channel enable
>>>  configure channel
>>>  handle transfer #1
>>>  configure channel
>>>  handle transfer #2
>>>  ...
>>>  SPI channel disable
>>> ]
>>> If we can disable channel before configure it and reenable
>>> channel after it is configured, it will be more safe.
>>>
>>> The commit a330ce2 "omap2_mcspi: Flush posted writes" make this risk
>>> to a real problem for ads7846 driver on omap3530evm. The
>>> ads7846 driver will send a SPI messge which includes,
>>> [
>>>  TX_ONLY transfer (1 byte)
>>>  RX_ONLY transfer (2 bytes)
>>>  TX_ONLY transfer (1 byte)
>>>  RX_ONLY transfer (2 bytes)
>>> ]
>>> If we don't add disable/reenable channel between TX and RX 
>transfers,
>>> the RX transfer will get wrong datas sent from slave.
>>>     
>>
>> I don't understand the problem description.  Are you talking about
>> manipulation of the SS line, or a problem with the internal state on
>> the mcspi controller device?  What is the cause of the wrong 
>data (ie.
>> is there a protocol error on the wire, or is the SPI controller not
>> performing the read correctly?)
>>
>> Thanks,
>> g.
>>
>>   
>Sorry for unclear description.  The problem is like that, when 
>a TX_ONLY 
>transfer is
>followed by a RX_ONLY transfer, the first data received in RX_ONLY 
>transfer will be
>the last data(random data) which is received in TX_ONLY 
>transfer instead 
>of a meaningful data.
>
>Thing like following logic,
>In TX_ONLY transfer:
>write data1(trigger transmit), (will receive a data 
>simultaneously, and 
>keep it in RX register)
>...
>write dataN(last data), (will receive the last random data and keep it 
>in RX register)
>in the following RX_ONLY transfer:
>change SPI controller to RX_ONLY mode,
>the RXS bit will be set to status register immediately,
>write a dummy data to TX register to trigger this session(in 
>fact this  
>trigger  doesn't take  effect),
>check the RXS bit and read the first data(the first data is the last 
>random data received in TX_ONLY transfer).
>

For me it is very strange that you have RXS bit set after TX_ONLY transmission.
The problem might be elsewhere and your solution will just mask the real problem.
Can you enable the spi debug and error logs and show them for your broken case.

Regards
Roman Tereshonkov

>
>But if we disable this channel after the TX_ONLY  transfer and 
>reenable 
>it  before  the RX_ONLY  transfer,
>the trigger action will take effect and a meaningful data  will be  
>transfered to RX register.
>
>Thanks,
>Jason.
>
>>> Signed-off-by: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/spi/omap2_mcspi.c |   16 ++++++----------
>>>  1 files changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>>>     
>[snip]
>
------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
