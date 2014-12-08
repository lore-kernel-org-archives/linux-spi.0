From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH v3 4/4] ARM: sti: Provide DT nodes for
 SBC SSC[0..2]
Date: Mon, 8 Dec 2014 13:15:58 +0000
Message-ID: <20141208131558.GA29220@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1418043214-14324-1-git-send-email-lee.jones@linaro.org>
 <1418043214-14324-5-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, kernel@stlinux.com,
	linux-spi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418043214-14324-5-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lee,

On Mon, 08 Dec 2014, Lee Jones wrote:

> The Synchronous Serial Controller is used to provide SPI.
> 
> These are the ports which are located on the Stand-By Controller (SBC).

After my series which adds stih410 SoC support, these nodes should now live in the
common stih407-family.dtsi file (common to both SoC's).

regards,

Peter.
