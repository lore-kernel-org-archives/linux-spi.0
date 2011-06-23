From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 08/11] spi-dw: Ensure fifo lenght is set.
Date: Wed, 22 Jun 2011 21:20:11 -0700
Message-ID: <4E02BEFB.2030508@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-9-git-send-email-dirk.brandewie@gmail.com> <BANLkTi=Jv2aVuHqVXh77aGxMFV_Q_wXQCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=Jv2aVuHqVXh77aGxMFV_Q_wXQCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/22/2011 08:55 PM, Grant Likely wrote:
> On Wed, Jun 22, 2011 at 8:00 PM,<dirk.brandewie@gmail.com>  wrote:
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> Bug on fifo_len not being set.  The fifo sizing routine does not work
>> since the txfltr register can not be written while the controller is
>> enabled. The max value of txfltr can be larger than the fifo.  The
>> register allows values upto 0x3f (63) the fifo depth on the Intel
>> SOC's if 40
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>> ---
>>   drivers/spi/spi-dw.c |   18 ++----------------
>>   1 files changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index ad92826..cc38aa0 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -776,25 +776,11 @@ static int destroy_queue(struct spi_dw *dws)
>>   /* Restart the controller, disable all interrupts, clean rx fifo */
>>   static void spi_dw_hw_init(struct spi_dw *dws)
>>   {
>> +       BUG_ON(!dws->fifo_len);
>> +
>
> Ditto here.  BUG is too big a reaction.  Fail to initialize the
> device, sure, and print a warning, but don't BUG.

Ack,  I was trying to make sure the bug got caught while I was working towards 
getting the rest of my changes in.

--Dirk
