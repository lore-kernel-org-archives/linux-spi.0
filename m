From: Masanari Iida <standby24x7@gmail.com>
Subject: [linux-next] make xmldoc failed with commit d780c3711d9df9bac
Date: Tue, 16 Feb 2016 22:51:58 +0900
Message-ID: <CALLJCT0GUZgiZnzdh+-pMuvYe4Pjo46BHebbDJwot4wkDBseUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: kernel@martin.sperl.org, broonie@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc <linux-doc@vger.kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

make xmldocs on linux-next as of 16th/Feb, 2016 failed with error.

.//include/linux/spi/spi.h:932: error: Cannot parse struct or union!
.//drivers/spi/spi.c:2179: warning: No description found for parameter 'gfp'
.//drivers/spi/spi.c:2350: warning: No description found for parameter 'msg'
.//drivers/spi/spi.c:2350: warning: No description found for parameter 'maxsize'
.//drivers/spi/spi.c:2350: warning: No description found for parameter 'gfp'
.//drivers/spi/spi.c:2350: warning: Excess function parameter
'message' description in 'spi_split_transfers_maxsize'
.//drivers/spi/spi.c:2350: warning: Excess function parameter
'max_size' description in 'spi_split_transfers_maxsize'
.//drivers/spi/spi.c:2179: warning: No description found for parameter 'gfp'
.//drivers/spi/spi.c:2350: warning: No description found for parameter 'msg'
.//drivers/spi/spi.c:2350: warning: No description found for parameter 'maxsize'
.//drivers/spi/spi.c:2350: warning: No description found for parameter 'gfp'
.//drivers/spi/spi.c:2350: warning: Excess function parameter
'message' description in 'spi_split_transfers_maxsize'
.//drivers/spi/spi.c:2350: warning: Excess function parameter
'max_size' description in 'spi_split_transfers_maxsize'
make[1]: *** [Documentation/DocBook/device-drivers.xml] Error 2
make: *** [xmldocs] Error 2
$

git bisect pointed out the first bad commit as

d780c3711d9df9bacd56b71cf23443b895a331ca is the first bad commit
commit d780c3711d9df9bacd56b71cf23443b895a331ca
Author: Martin Sperl <kernel@martin.sperl.org>
Date:   Mon Dec 14 15:20:18 2015 +0000

    spi: core: added spi_resource management

    SPI resource management framework used while processing a spi_message
    via the spi-core.

Masanari Iida
