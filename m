From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] acpi: Export acpi_of_modalias equiv of
 of_modalias_node
Date: Thu, 16 Jun 2016 11:04:05 +0300
Message-ID: <20160616080405.GS1740@lahna.fi.intel.com>
References: <cover.1466014238.git.leonard.crestez@intel.com>
 <2cc8100c0c0f79a56163429aaefc0fcfecc808f4.1466014238.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cc8100c0c0f79a56163429aaefc0fcfecc808f4.1466014238.git.leonard.crestez@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2016 at 09:30:27PM +0300, Crestez Dan Leonard wrote:
> +int acpi_of_modalias(struct acpi_device *adev, char *outstr, int outlen)

Why not size_t for outlen?
