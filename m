From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
Date: Fri, 4 Mar 2016 22:31:33 -0600
Message-ID: <20160305043133.GI13525@rob-hp-laptop>
References: <1457099082-12587-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@linux-mips.org,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
To: Purna Chandra Mandal <purna.mandal@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457099082-12587-1-git-send-email-purna.mandal@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 04, 2016 at 07:14:41PM +0530, Purna Chandra Mandal wrote:
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> ---
> 
> Changes in v2:
>  - fix indentation
>  - add space after comma
>  - moved 'cs-gpios' section under 'required' properties.
> 
>  .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

Acked-by: Rob Herring <robh@kernel.org>
