From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v11 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 22 Apr 2019 22:00:13 +0300
Message-ID: <a06cd796-1afc-ecf9-505d-efb615aebf73@cogentembedded.com>
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
 <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/22/2019 09:32 PM, Sergei Shtylyov wrote:

>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
> 
>   Do dote that I'm opposed to the driver separation as it's presented in

   Sorry, s/dote/note/.

> this patches, and I have a large patch reworking both MFD and SPI drivers
> in the works.

[...]

MBR, Sergei
