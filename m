From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] spi: ti-qspi: Implement the spi_mem interface
Date: Sat, 17 Feb 2018 16:31:48 +0530
Message-ID: <55878296-f1c9-434b-3c7e-e2f03f5824a9@ti.com>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
 <20180205232120.5851-5-boris.brezillon@bootlin.com>
 <6a9eaaaf-20a6-b332-03d0-9d16e24d0b3d@ti.com>
 <20180212133158.3032442f@bbrezillon>
 <67e61203-a2e9-853c-6cda-7226499611c2@ti.com>
 <20180212170809.3f0b5e20@bbrezillon>
 <0944fefa-6ef8-a93a-dad6-660044b8ec8e@ti.com>
 <20180214200952.6a8578dc@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180214200952.6a8578dc@bbrezillon>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


[...]
>>>>>>     
>>>>>>> +static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
>>>>>>> +   .exec_op = ti_qspi_exec_mem_op,      
>>>>>>
>>>>>>         .supports_op = ti_qspi_supports_mem_op,
>>>>>>
>>>>>> Its required as per spi_controller_check_ops() in Patch 1/6    
>>>>>     
>>>>> ->supports_op() is optional, and if it's missing, the core will do the    
>>>>> regular QuadSPI/DualSPI/SingleSPI check (see spi_mem_supports_op()
>>>>> implementation).     
>>>>
>>>> You might have overlooked spi_controller_check_ops() from Patch 1/6:
>>>> +static int spi_controller_check_ops(struct spi_controller *ctlr)
>>>> +{
>>>> +	/*
>>>> +	 * The controller can implement only the high-level SPI-memory
>>>> +	 * operations if it does not support regular SPI transfers.
>>>> +	 */
>>>> +	if (ctlr->mem_ops) {
>>>> +		if (!ctlr->mem_ops->supports_op ||
>>>> +		    !ctlr->mem_ops->exec_op)
>>>> +			return -EINVAL;
>>>> +	} else if (!ctlr->transfer && !ctlr->transfer_one &&
>>>> +		   !ctlr->transfer_one_message) {
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>
>>>> So if ->supports_op() is not populated by SPI controller driver, then
>>>> driver probe fails with -EINVAL. This is what I observed on my TI
>>>> hardware when testing this patch series.  
>>>
>>> Correct. Then I should fix spi_controller_check_ops() to allow empty
>>> ctlr->mem_ops->supports_op.
>>>   
>>>>  
>>>>> This being said, if you think a custom ->supports_op()
>>>>> implementation is needed for this controller I can add one.
>>>>>     
>>>>
>>>> spi_mem_supports_op() should suffice for now if above issue is fixed.  
>>>
>>> Cool. IIUC, you tested the series on a TI SoC. Does it work as
>>> expected? Do you see any perf regressions?
>>>   

No other functional failures or performance issues so far wrt TI QSPI.
Things look good :)


-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
