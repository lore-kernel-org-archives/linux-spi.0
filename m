From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: rename SPINOR_OP_* macros of the 4-byte
 address op codes
Date: Wed, 7 Dec 2016 17:08:46 +0100
Message-ID: <be0718c0-b463-79e0-53b9-d85b29f24465@gmail.com>
References: <cover.1481041702.git.cyrille.pitchen@atmel.com>
 <54697ac9604b8e769f92dd4fb392db952df9eae4.1481041702.git.cyrille.pitchen@atmel.com>
 <20161207095148.glwlxbd2tatr7axo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: computersforpeace@gmail.com, boris.brezillon@free-electrons.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161207095148.glwlxbd2tatr7axo@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/07/2016 10:51 AM, Mark Brown wrote:
> On Tue, Dec 06, 2016 at 05:52:31PM +0100, Cyrille Pitchen wrote:
>> This patch renames the SPINOR_OP_* macros of the 4-byte address
>> instruction set so the new names all share a common pattern: the 4-byte
>> address name is built from the 3-byte address name appending the "_4B"
>> suffix.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
It's certainly less confusing naming, so

Acked-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
