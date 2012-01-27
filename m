From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] spi: spi-sh: add IORESOURCE_MEM_TYPE_MASK decoding for
 access size
Date: Fri, 27 Jan 2012 10:14:49 +0900
Message-ID: <4F21FA89.4060709@renesas.com>
References: <4F21124D.6030601@renesas.com> <20120126102220.GE26283@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <20120126102220.GE26283@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2012/01/26 19:22, Paul Mundt wrote:
> On Thu, Jan 26, 2012 at 05:43:57PM +0900, Shimoda, Yoshihiro wrote:
[ snip ]
>>  static void spi_sh_set_bit(struct spi_sh_data *ss, unsigned long val,
>> @@ -464,6 +473,18 @@ static int __devinit spi_sh_probe(struct platform_device *pdev)
>>  	ss = spi_master_get_devdata(master);
>>  	dev_set_drvdata(&pdev->dev, ss);
>>
>> +	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
>> +	case IORESOURCE_MEM_8BIT:
>> +		ss->width = 8;
>> +		break;
>> +	case IORESOURCE_MEM_32BIT:
>> +		ss->width = 32;
>> +		break;
>> +	default:
>> +		dev_err(&pdev->dev, "No support width\n");
>> +		ret = -ENODEV;
>> +		goto error1;
> 
> If the default up to this point has been 32-bit only then it makes sense
> for 32 to still remain the default. The 8-bit user is presumably a new
> one and therefore has no existing platform data configuration to worry
> about, while this change would require existing users to be updated for
> the new 32-bit flag to behave the same way they have up until now. 

Thank you for your comment.
Unfortunately, the value of IORESOURCE_MEM_8BIT is (0<<3), so existing users
will not enter to the default.

> If you wish to do this incrementally then you can of course convert all
> of the existing platforms to the new mechanism for 32-bit as well and
> then simply error out as above for the undefined width case, but I still
> think it makes more sense to have a usable default.

I think so. But, I think I cannot write such a code using IORESOURCE_MEM_*BIT
by the above reason.
At the moment, existing platform which uses this driver is one only. And,
I already sent a patch to modify the resource.
http://marc.info/?l=linux-sh&m=132756762518679&w=2

Best regards,
Yoshihiro Shimoda
