From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
Date: Sat, 22 Feb 2020 23:42:26 +0300
Message-ID: <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Mason Yang <masonccyang-I/i+R0kf0WFNUHwG+Fw1Kw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Behme Dirk (CM/ESO2)" <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5760bcdb-e44b-6f18-7262-9526684e5780-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Content-Language: en-MW
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 02/10/2020 01:21 PM, Behme Dirk (CM/ESO2) wrote:

>> Add the memory driver for Renesas RPC-IF which registers either SPI or
>> HyperFLash device depending on the contents of the device tree subnode.
>> It also provides the absract "back end" device APIs that can be used by
>> the "front end" SPI/MTD drivers to talk to the real hardware.
>>
>> Based on the original patch by Mason Yang <masonccyang-I/i+R0kf0WFNUHwG+Fw1Kw@public.gmane.org>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> 
> 
> FYI, please find below [1] the changes I did locally on this driver. It seems to read & write successfully on my custom M3 (R8A7796) device, now.

   Not for me...
   BTW, your patch had whitespace ruined, I had to apply it by hand, you'd better
attach the patches, not paste. :-/

> Best regards
> 
> Dirk
> 
> [1]
> 
> From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
> From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> Date: Tue, 4 Feb 2020 08:39:31 +0100
> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>  clean up
> 
> This is required to make the driver work correctly in my M3 environment.
> 
> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index 04be92b64bfa..f4356b066384 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
[...]
> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>      pm_runtime_get_sync(rpc->dev);
> 
>      regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
> -    regmap_write(rpc->regmap, RPCIF_DRCR,
> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
> -    regmap_write(rpc->regmap, RPCIF_DREAR,
> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
> -    regmap_write(rpc->regmap, RPCIF_DRENR,
> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);

   The driver somehow works only with this left in place (with 2 bytes eaten
as before), otherwise all the flash reads all 0xff (via dirmap).

> +    ret = wait_msg_xfer_end(rpc);
> +    if (ret) {
> +        len = 0;
> +        goto err_out;
> +    }
> 
>      memcpy_fromio(buf, rpc->dirmap + from, len);
> 
> +err_out:
>      pm_runtime_put(rpc->dev);
> 
>      return len;

MBR, Sergei
