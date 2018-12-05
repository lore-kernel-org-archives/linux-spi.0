From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
Date: Wed, 5 Dec 2018 21:56:57 +0300
Message-ID: <8de55806-ee08-69c6-df1b-45b1eba607a6@cogentembedded.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
 <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/04/2018 09:19 PM, Marek Vasut wrote:

>> Document the bindings used by the Renesas R-Car Gen3 RPC SPI controller.
> 
> RPC is SPI and HF controller, it is not a pure SPI controller.
> 
> How does this deal with the HF part ? Keep in mind the bindings are ABI
> and it will be difficult to redo them later.

   Perhaps we need a "mode" prop, maybe w/vendor prefix? 

>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]

MBR, Sergei
