From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: Re: [PATCH] spi: sh-msiof: Update calculation of frequency dividing
Date: Thu, 15 Jan 2015 10:27:46 +0900
Message-ID: <54B71792.9030900@renesas.com>
References: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com> <54B6518B.4080607@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<geert@glider.be>, <yoshihiro.shimoda.uh@renesas.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <54B6518B.4080607@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Thanks for your review.

(2015/01/14 20:22), Sergei Shtylyov wrote:
> Hello.
>
> On 1/14/2015 10:25 AM, Nobuhiro Iwamatsu wrote:
>
>> sh-msiof of frequency dividing does not perform the calculation, driver have
>> to manage setting value in the table. It is not possible to set frequency
>> dividing value close to the actual data in this way. This changes from
>> frequency dividing of table management to setting by calculation.
>> This driver is able to set a value close to the actual data.
>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>> drivers/spi/spi-sh-msiof.c | 39 +++++++++++++++++----------------------
>> 1 file changed, 17 insertions(+), 22 deletions(-)
>
>> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
>> index 96a5fc0..58b1bfe 100644
>> --- a/drivers/spi/spi-sh-msiof.c
>> +++ b/drivers/spi/spi-sh-msiof.c
>> @@ -241,42 +241,37 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
> [...]
>> - k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
>> -
>> - sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
>> + scr = sh_msiof_spi_div_table[k].brdv | (brps -1) << 8;
>
> You forgot a space after '-'.

Thanks.
I will use SCR_BRPS instead of -1 as comment from Geert.

>
> [...]
>
> WBR, Sergei
>

Best regards,
   Nobuhiro
