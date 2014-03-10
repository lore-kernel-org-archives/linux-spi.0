From: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Prevent NULL pointer dereference
Date: Mon, 10 Mar 2014 08:48:40 -0700
Message-ID: <201403100848.41186.sfking@fdwdc.com>
References: <1394345470.15686.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394345470.15686.1.camel@phoenix>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Saturday 08 March 2014 10:11:10 pm Axel Lin wrote:
> If pdata->cs_control is NULL, we will hit NULL pointer dereference in
> mcfqspi_cs_select() and mcfqspi_cs_deselect(). Thus add NULL test for
> pdata->cs_control in probe().
>

NAK.

 I suggest you read the code again.  There is no NULL pointer dereference and 
further, by returning an error if cs_control is NULL, you've now broken the 
design which was that cs_control is optional.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
