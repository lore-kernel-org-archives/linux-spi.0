From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Subject: Re: linux-next: manual merge of the spi tree with the pm tree
Date: Fri, 18 Aug 2017 11:17:20 +0530
Message-ID: <f986d7eb-78b0-f4e8-4d5d-aa13b5fdc200@techveda.org>
References: <20170817132308.090d4b88@canb.auug.org.au>
 <20170817072142.GA11056@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170817072142.GA11056-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 17 August 2017 12:51 PM, Lukas Wunner wrote:
> Hi Sunil, Hi Karthik,
> 
> On Thu, Aug 17, 2017 at 01:23:08PM +1000, Stephen Rothwell wrote:
>>   9b61e302210e ("spi: Pick spi bus number from Linux idr or spi alias")
> 
> This commit contains numerous trailing whitespace and space as indentation
> issues.  Please be sure to run your patches through scripts/checkpatch.pl
> before submission to avoid this.
> 

Hi Lukas,

Thanks for pointing out checkpatch issues. checkpatch clean-up is done 
and a patch has been sent which is now applied to broonie's spi tree.
 
> Thanks,
> 
> Lukas
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
