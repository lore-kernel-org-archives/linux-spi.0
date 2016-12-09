From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v9 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Fri, 9 Dec 2016 14:05:54 +0100
Message-ID: <6dc1eb03-5e0e-84cf-ee2e-e3d7f8cb7a42@denx.de>
References: <1481261749-15301-1-git-send-email-joel@airwebreathe.org.uk>
 <1481261749-15301-3-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>,
        atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481261749-15301-3-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12/09/2016 06:35 AM, Joel Holdsworth wrote:
> The Lattice iCE40 is a family of FPGAs with a minimalistic architecture
> and very regular structure, designed for low-cost, high-volume consumer
> and system applications.
> 
> This patch adds support to the FPGA manager for configuring the SRAM of
> iCE40LM, iCE40LP, iCE40HX, iCE40 Ultra, iCE40 UltraLite and iCE40
> UltraPlus devices, through slave SPI.
> 
> The iCE40 family is notable because it is the first FPGA family to have
> complete reverse engineered bit-stream documentation for the iCE40LP and
> iCE40HX devices. Furthermore, there is now a Free Software Verilog
> synthesis tool-chain: the "IceStorm" tool-chain.
> 
> This project is the work of Clifford Wolf, who is the maintainer of
> Yosys Verilog RTL synthesis framework, and Mathias Lasser, with notable
> contributions from "Cotton Seed", the main author of "arachne-pnr"; a
> place-and-route tool for iCE40 FPGAs.
> 
> Having a Free Software synthesis tool-chain offers interesting
> opportunities for embedded devices that are able reconfigure themselves
> with open firmware that is generated on the device itself. For example
> a mobile device might have an application processor with an iCE40 FPGA
> attached, which implements slave devices, or through which the processor
> communicates with other devices through the FPGA fabric.
> 
> A kernel driver for the iCE40 is useful, because in some cases, the FPGA
> may need to be configured before other devices can be accessed.
> 
> An example of such a device is the icoBoard; a RaspberryPI HAT which
> features an iCE40HX8K with a 1 or 8 MBit SRAM and ports for
> Digilent-compatible PMOD modules. A PMOD module may contain a device
> with which the kernel communicates, via the FPGA.
> 
> Signed-off-by: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>

Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
