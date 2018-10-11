From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI  controller
Date: Thu, 11 Oct 2018 17:17:30 -0500
Message-ID: <20181011221730.GA7293@bogus>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 11 Oct 2018 11:00:38 +0000, Yogesh Narayan Gaur wrote:
> Add binding file for NXP FlexSPI controller
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - Removed node property 'big-endian'.
> Changes for v2:
> - Incorporated Rob review comments.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
