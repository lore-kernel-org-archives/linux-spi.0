From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 01/12] misc: add driver for sequencer serial port
Date: Wed, 20 Oct 2010 09:22:16 -0600
Message-ID: <20101020152216.GA7285@angua.secretlab.ca>
References: <1287429922-18870-1-git-send-email-cyril@ti.com>
	<1287429922-18870-2-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287429922-18870-2-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 18, 2010 at 03:25:11PM -0400, Cyril Chemparathy wrote:
> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device.  It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
> 
> This patch adds a driver for this controller device.  The driver does not
> expose a user-land interface.  Protocol drivers built on top of this layer are
> expected to remain in-kernel.
> 
> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>

I like this version much better.

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
