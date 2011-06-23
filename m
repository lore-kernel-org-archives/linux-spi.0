From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 06/11] spi-dw: Force error on out of range chip select.
Date: Wed, 22 Jun 2011 21:13:38 -0700
Message-ID: <4E02BD72.8040007@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-7-git-send-email-dirk.brandewie@gmail.com> <BANLkTin5CFVm6rVM_c6RRranJEor_jPF=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTin5CFVm6rVM_c6RRranJEor_jPF=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/22/2011 08:51 PM, Grant Likely wrote:
> On Wed, Jun 22, 2011 at 8:00 PM,<dirk.brandewie@gmail.com>  wrote:
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> BUG_ON() if the selected chip select is out of range.
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>> ---
>>   drivers/spi/spi-dw.h |    3 +--
>>   1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index 860bc34..3fa4c13 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -178,8 +178,7 @@ static inline void spi_dw_set_clk(struct spi_dw *dws, u16 div)
>>
>>   static inline void spi_dw_chip_sel(struct spi_dw *dws, u16 cs)
>>   {
>> -       if (cs>  dws->num_cs)
>> -               return;
>> +       BUG_ON(cs>= dws->master->num_chipselect);
>
> BUG is rather an over-reaction.  The transfer should be rejected if
> the cs# is invalid, and a warning message is appropriate, but BUG() is
> too extreme.

This is extreme I agree, the current driver will fail silently if an out of 
range chip select is requested.

We can drop this one for now and I will put a proper check in probe/init so we 
won't get here.



>
> g.
