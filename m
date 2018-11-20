From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Date: Tue, 20 Nov 2018 14:33:02 +0100
Message-ID: <1597e984-6b69-1d1e-f033-296d658f8011@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <20181119152735.GB3535@sirena.org.uk>
 <cbbc3dba-7f85-c6a3-525f-01eb23e50592@gmail.com>
 <20181120132624.GD3894@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mason Yang <masonccyang@mxic.com.tw>, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120132624.GD3894@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/20/2018 02:26 PM, Mark Brown wrote:
> On Mon, Nov 19, 2018 at 11:10:04PM +0100, Marek Vasut wrote:
>> On 11/19/2018 04:27 PM, Mark Brown wrote:
> 
>>> The SPDX header needs to be C++ style so I push people to make the whole
>>> block C++ otherwise it looks messy.
> 
>> OK, I'm not gonna wrestle you on this, but I think it looks horrible ;-)
> 
> I don't really like the C++ comment in the first place :(

Then we are in agreement :-)

-- 
Best regards,
Marek Vasut
