From: Alexander Sverdlin <alexander.sverdlin@nsn.com>
Subject: Re: [PATCH] of: spi: Export single device registration method and
 accessors (v2)
Date: Wed, 29 Oct 2014 10:08:59 +0100
Message-ID: <5450AEAB.40200@nsn.com>
References: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robherring2@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Matt Porter <matt.porter@linaro.org>,
	Koen Kooi <koen@dominion.thruhere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Chaiken <Alison_Chaiken@mentor.com>,
	Dinh Nguyen <dinh.linux@gmail.com>,
	Jan Lubbe <jluebbe@lasnet.de>, Michael Stickel <ms@mycable.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Dirk Behme <dirk.behme@gmail.com>,
	Alan Tull <delicious.quinoa@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Michael Bohan <mbohan@codeaurora.org>,
	Ionut Nicu <ioan.nicu.ext@nsn.com>,
	Michal Simek <monstr@monstr.eu>,
	Matt Ranostay <mranostay@gmail.com>,
	Joel Becker <jlbec@evilplan.org>, devicetree@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-ke
To: ext Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 29/10/14 09:40, ext Pantelis Antoniou wrote:
> Dynamically inserting spi device nodes requires the use of a single
> device registration method. Rework and export it.
> 
> Methods to lookup a device/master using a device node are added
> as well, of_find_spi_master_by_node() & of_find_spi_device_by_node().
> 
> Changes since v1:
> * Brown paper bug with parameter on of_register_spi_device().
> 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Acked-by: Alexander Sverdlin <alexaner.sverdlin@nsn.com>

> ---
>  drivers/spi/spi.c | 255 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 157 insertions(+), 98 deletions(-)

-- 
Best regards,
Alexander Sverdlin.
