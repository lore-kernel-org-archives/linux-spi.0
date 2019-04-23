From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v11 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Tue, 23 Apr 2019 19:09:22 +0300
Message-ID: <060316c8-7675-cfaf-bfef-c3e6458bfa82@cogentembedded.com>
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
 <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
 <OFF96C004A.0EFDDD69-ON482583E5.0032EE18-482583E5.00337F42@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFF96C004A.0EFDDD69-ON482583E5.0032EE18-482583E5.00337F42@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/23/2019 12:22 PM, masonccyang@mxic.com.tw wrote:

>> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> [...]
>>
>>   Do dote that I'm opposed to the driver separation as it's presented in
>> this patches, and I have a large patch reworking both MFD and SPI drivers
>> in the works.
>>
> 
> Do you mean add your name in both MFD & dt-binding ?

   Of course not!

> i.e.,
> [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF MFD bindings
> 
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> 
> 
> [PATCH v12 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver
> 
> Add a driver for Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> 
> Is it ok ?

   I'm not OK with the most of the driver code ending up in the SPI driver,
I think most of the code should be kept in the MFD driver and just be called
by SPI/HF drivers.

> best regards,
> Mason

MBR, Sergei
