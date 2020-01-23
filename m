From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v7 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Thu, 23 Jan 2020 18:05:22 +0800
Message-ID: <e0e7470a-c40e-9431-d88c-221c4741d4a0@linux.intel.com>
References: <20200122091340.43986-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200122091340.43986-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <617ec5c7-59a0-1e09-bdd7-126a5792889d@ti.com>
 <1aedd2ad-5795-2500-286f-fb55209991f8@linux.intel.com>
 <a4b33129-5ac3-d4d1-c8ba-f170f0f9ee03@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a4b33129-5ac3-d4d1-c8ba-f170f0f9ee03-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 23/1/2020 5:58 PM, Vignesh Raghavendra wrote:
>
> On 23/01/20 3:14 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>> +};
>>>> +
>>>> +struct spi_mem_op_cadence {
>>>> +    const void    *tx_buf;
>>>> +    void        *rx_buf;
>>>> +    u32        len;
>>>> +    u32        tx_nbits:3;
>>>> +    u32        rx_nbits:3;
>>>> +};
>>>> +
>>> Please drop thesee.. See further below for more info.
>> it's required for qspi-nand.
> I don't see a need to mimic fields of spi_mem_op inside this driver. Why
> not use them directly where needed?
>
> Looking at the patch:
>
> rx_nbits is never used.
> tx_nbits is assigned value but never used
> rx_buf is never used
>
> tx_buf aliases to addrbuf which can be easily derived from op->addr.val
>
Sure, I will derive it.
Thank you

Regards
Vadivel
>
>
