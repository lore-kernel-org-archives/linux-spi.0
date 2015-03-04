From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: qup: Add DMA capabilities
Date: Wed, 04 Mar 2015 11:37:17 +0200
Message-ID: <54F6D24D.2050509@linaro.org>
References: <1425056312-13746-1-git-send-email-stanimir.varbanov@linaro.org> <1425458290.5705.2.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425458290.5705.2.camel-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/04/2015 10:38 AM, Ivan T. Ivanov wrote:
> 
> Hi Stan,
> 
> It looks good now, except it doesn't apply and two small issues below:
> 

<snip>

> 
>> +
>> +       /* set DMA parameters */
>> +       rx_conf->direction = DMA_DEV_TO_MEM;
>> +       rx_conf->device_fc = 1;
> 
> Strictly speeching this is a bool not int.

sure will correct.

>>
>> +       ret = spi_qup_init_dma(master, res->start);
>> +       if (ret == -EPROBE_DEFER)
>> +               goto error;
>> +       else if (!ret)
>> +               master->can_dma = spi_qup_can_dma;
>> +
>>         /* set v1 flag if device is version 1 */
>>         if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
>>                 controller->qup_v1 = 1;
> 
> It is not visible from this patch, but in case of error reseting
> SPI controller (QUP_STATE_RESET), exit error path should be 
> 'error_dma' and not 'error' label.

my fault, will correct.

regards,
Stan


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
