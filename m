From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] spi: Enable Cadence SPI driver for ARM64
Date: Tue, 24 Feb 2015 09:23:29 +0100
Message-ID: <16fcf6871bb9482a89a5ca5827c78286@BN1BFFO11FD047.protection.gbl>
References: <859f9c4d3fbbc5153d924d7a6e36aa3a734e1b16.1424763838.git.michal.simek@xilinx.com>
 <20150224080807.GS6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224080807.GS6236@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/24/2015 09:08 AM, Mark Brown wrote:
> On Tue, Feb 24, 2015 at 08:44:01AM +0100, Michal Simek wrote:
>> This driver is used on new Xilinx ZynqMP SoC.
> 
> Why does this have an architecture dependence at all?

Let me push this to my repo and run Fenguang's system on it if there
is any build error on others architectures.
I expect that this could be sufficient test, right?

Thanks,
Michal
