From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Add Spreadtrum ADI controller
 documentation
Date: Wed, 20 Sep 2017 15:52:24 -0500
Message-ID: <20170920130844.jdfxlhlkseiytqb5@rob-hp-laptop>
References: <385c61101941f4a7329d3092f0339514c531b740.1505388996.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
To: Baolin Wang <baolin.wang@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <385c61101941f4a7329d3092f0339514c531b740.1505388996.git.baolin.wang@spreadtrum.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 15, 2017 at 03:29:15PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum ADI
> controller device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
> ---
> Changes since v2:
>  - Add some documentation to describe how many hardware channels can be
>  configured.
>  - Remove "SPI framework" from binding file and other small optimization.
> 
> Changes since v1:
>  - Add more documentation for the 'sprd,hw-channels' property and explain
>  why need one hardware spinlock.
> ---
>  .../devicetree/bindings/spi/spi-sprd-adi.txt       |   58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt

Acked-by: Rob Herring <robh@kernel.org>
