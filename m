From: jason <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable
 chan between each SPI transfer
Date: Fri, 25 Jun 2010 20:05:53 +0800
Message-ID: <4C249BA1.8010808@gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD83846FB@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1C7579D1379824DAE67858071C810382DD83846FB-xJW1crHCIS+8kqYwC468Frtp2NbXvJi8gfoxzgwHRXE@public.gmane.org>
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
>  
>
>   
[snip]
>> -----Original Message-----
>>
>> 					}
>> 					c = 0;
>> -				} else if (c == 0 && tx == NULL) {
>> -					omap2_mcspi_set_enable(spi, 0);
>> 				}
>>
>> 				*rx++ = __raw_readl(rx_reg);
>>     
>
> Why do you do this?
> Reading the last word from the shift register buffer leads to 
> the receiving new data to the buffer.
> The channel needs to be disabled before the last word reading.
>
>
>   
Yes, you are right. If this patch can be accepted, i will remove those 
changes in the V2 patch.
Please see my email replying grant likely's questions.

Thanks,
Jason.
>   
>> @@ -646,7 +641,7 @@ omap2_mcspi_txrx_pio(struct spi_device 
>> *spi, struct spi_transfer *xfer)
>> 			dev_err(&spi->dev, "EOT timed out\n");
>> 	}
>> out:
>> -	omap2_mcspi_set_enable(spi, 1);
>> +	omap2_mcspi_set_enable(spi, 0);
>> 	return count - c;
>> }
>>
>> @@ -894,7 +889,6 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> 		cs = spi->controller_state;
>> 		cd = spi->controller_data;
>>
>> -		omap2_mcspi_set_enable(spi, 1);
>> 		list_for_each_entry(t, &m->transfers, transfer_list) {
>> 			if (t->tx_buf == NULL && t->rx_buf == 
>> NULL && t->len) {
>> 				status = -EINVAL;
>> @@ -931,6 +925,8 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>>
>> 			mcspi_write_chconf0(spi, chconf);
>>
>> +			omap2_mcspi_set_enable(spi, 1);
>> +
>> 			if (t->len) {
>> 				unsigned	count;
>>
>> -- 
>> 1.5.6.5
>>
>>
>>     


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
