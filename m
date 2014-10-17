From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Subject: Re: [v3] spi: orion: support armada extended baud rates
Date: Fri, 17 Oct 2014 14:53:53 +1000
Message-ID: <5440A0E1.5080700@uclinux.org>
References: <20141011144857.GA17350@gobelin> <543C8460.1060508@uclinux.org> <20141015131054.GA3243@gobelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karl Beldan <karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141015131054.GA3243@gobelin>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Karl,

On 15/10/14 23:10, Karl Beldan wrote:
> On Tue, Oct 14, 2014 at 12:03:12PM +1000, Greg Ungerer wrote:
>> Hi Karl,
>>
>> On 12/10/14 00:52, Karl Beldan wrote:
>>> On 28/09/14 23:24:04, Greg Ungerer wrote:
>>>> @@ -378,6 +452,10 @@ static int orion_spi_probe(struct platform_device *pdev)
>>>>  	spi = spi_master_get_devdata(master);
>>>>  	spi->master = master;
>>>>  
>>>> +	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
>>>> +	devdata = of_id->data;
>>>> +	spi->devdata = devdata;
>>>> +
>>> Won't of_match_device return NULL on non-DT systems, and further
>>> references oops ?
>>
>> Yes, sure enough.
>>
>> So I propose to fix with this change.
>>
>> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
>> index acf8e48..c069ccd 100644
>> --- a/drivers/spi/spi-orion.c
>> +++ b/drivers/spi/spi-orion.c
>> @@ -453,7 +453,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>>         spi->master = master;
>>  
>>         of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
>> -       devdata = of_id->data;
>> +       devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
>>         spi->devdata = devdata;
>>  
> I am not aware of the policy in the DT subsystem, I see some drivers
> bailing out when not getting any match, some remove non-DT support and
> add a dependency on OF, yet a message would feel appropriate.
> Other than that ok, it should fix df59fa7f4bca.

Before the recent changes this driver didn't call of_match_device().
With the above fix in place if it does return NULL then it will behave
the same as it used to - using the default orion parameters. I think
that is the ideal behavior.

Regards
Greg




--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
