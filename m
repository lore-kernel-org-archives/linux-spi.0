From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] Blackfin SPI Driver: Add GPIO controlled SPI Slave
 Select support
Date: Thu, 5 Feb 2009 14:12:55 -0800
Message-ID: <20090205141255.2009f858.akpm@linux-foundation.org>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
	<1233828453-13311-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	cooloney@kernel.org
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752998AbZBEWNv@vger.kernel.org>
In-Reply-To: <1233828453-13311-5-git-send-email-cooloney@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu,  5 Feb 2009 18:07:32 +0800
Bryan Wu <cooloney@kernel.org> wrote:

> 
> This patch adds support for GPIO controlled SPI Chip Selects.
> To make use of this feature, set chip_select = 0 and add a proper
> cs_gpio to your controller_data.
> 
> struct spi_board_info
>         .chip_select = 0
> 
> struct bfin5xx_spi_chip
>         .cs_gpio = GPIO_P###
> 
> There are various SPI devices that require SPI MODE_0,
> and need to have the Chip Selects asserted during the entire transfer.
> Consider using SPI_MODE_3 (SPI_CPHA | SPI_CPOL) if your device allows
> it.

Cannot apply this due to previously-mentioned driver-core-tramplings.
