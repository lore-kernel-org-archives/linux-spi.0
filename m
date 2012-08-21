From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [2/2] spi: Add SPI master controller for OCTEON SOCs.
Date: Tue, 21 Aug 2012 13:38:02 -0700
Message-ID: <5033F1AA.4080308@caviumnetworks.com>
References: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <20120821194936.GA7145@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Daney <ddaney.cavm@gmail.com>,
	<devicetree-discuss@lists.ozlabs.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	<spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
	<linux-doc@vger.kernel.org>, David Daney <david.daney@cavium.com>
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120821194936.GA7145@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/21/2012 12:49 PM, Guenter Roeck wrote:
> On Fri, May 11, 2012 at 08:34:46PM -0000, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Add the driver, link it into the kbuild system and provide device tree
>> binding documentation.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
> [ ... ]
>
>> +
>> +static int __devexit octeon_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct octeon_spi *p = platform_get_drvdata(pdev);
>> +	struct spi_master *master = p->my_master;
>> +
>> +	spi_unregister_master(master);
>> +
>
> I know it is a bit late, but ...

In this case, just in time.  I am now finally getting back to fixing the 
issues with this driver, and looking to merging it in the near future.

David Daney

>
> The call to spi_unregister_master() frees the memory associated with master,
> ie 'p', and the spi_master_put() below without matching spi_master_get() is
> unnecessary/wrong. One possible fix would be to use
>
> 	struct spi_master *master = spi_master_get(p->my_master);
>
> above. That protects master and p while it is still being used, and makes use
> of the call to spi_master_put() below. Another option might be to move
> cvmx_write_csr() ahead of the call to spi_unregister_master() and drop the
> call to spi_master_put().
>
> Guenter
>
>> +	/* Clear the CSENA* and put everything in a known state. */
>> +	cvmx_write_csr(p->register_base + OCTEON_SPI_CFG, 0);
>> +	spi_master_put(master);
>> +	return 0;
>> +}
>> +
>


