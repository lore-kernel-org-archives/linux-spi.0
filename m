From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: qup: provide proper bus numbers
Date: Thu, 21 Jan 2016 18:47:34 +0000
Message-ID: <56A127C6.9000409@linaro.org>
References: <1453401227-27135-1-git-send-email-srinivas.kandagatla@linaro.org> <20160121183810.GN6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160121183810.GN6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 21/01/16 18:38, Mark Brown wrote:
> On Thu, Jan 21, 2016 at 06:33:47PM +0000, Srinivas Kandagatla wrote:
>
>> This driver reuses pdev->id for spi bus numbers resulting in random
>> or very large bus numbering when used with device trees. pdev->id
>> is not the correct choice when using device trees. So add code to
>
> What makes you say this, why is pdev->id not "correct"?  It is worrying
> if anything cares what number we pick.

Issue is that using pdev->id for bus number, as pdev->id does not get 
populated in device tree cases.

The end users who are reading the schematics would not be able to map 
the actual bus numbers on the schematics with the bus numbers allocated 
using pdev->id. It add more confusion.

Without this patch the bus number allocated to this driver is 32766.
This does not really reflect the actual bus numbers on the boards 
schematics.

>
>> get bus numbers via device tree aliases and if it fails then generate
>> a unique bus number.
>
> The other question is even if this is a good idea why is it something
> that should be open coded in individual drivers, if we want to change
> the policy we should be consistent between drivers.

Device tree aliases seems used very much in many drivers.
The unique bus number scheme was actually inspired by the 
driver/tty/serial/msm_serial.c

--srini

>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
