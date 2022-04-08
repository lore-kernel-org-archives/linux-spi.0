Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77BC433F5
	for <linux-spi@archiver.kernel.org>; Fri,  8 Apr 2022 18:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiDHSfX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiDHSfW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Apr 2022 14:35:22 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29351107CE;
        Fri,  8 Apr 2022 11:33:18 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f23so16582324ybj.7;
        Fri, 08 Apr 2022 11:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wtNwrz7oRIWjkIPNvrbEkRmxAgqdmLlbehB5ZSkoXhg=;
        b=BnQhROQvxrbGrbElkJbj7N/Oj8j5L7dnboqyh/6P9sjpz9JZG9ADzD7efNXRN6l5YQ
         y/gGmWwgEibNNLaSHwpwUjqDJWKp+XzuGbjMDEPt5SQkNyaIXUfrUatlGXf8xbw/MyQn
         7SlzrtmwRzT8SST92P04UK8xsgY/atZCGOFd7PPghXWFziNH9iJiKvxOfEWuEtFyI6cD
         qn4C1O04b7kyNKenBd092nPomkTjc5opjWfvzUt6oRo2qLsucCaAgw2j4n65lHsCgpyr
         RLf63x9F4pFMyLiYPXoSU8jH8Ai8dzjIp9x4oawUFMKtZqXaNzZXiaEOVoix804trpjW
         UXxQ==
X-Gm-Message-State: AOAM532CD5o7C7jpF48uesLvjsmE4HZrr/aZO5AijJeJ32NF4pIP/t/P
        t7/IcPBLZ+tjrRGb9nJgfrjR26m5V92SknKwHwUP6lc1J7Y=
X-Google-Smtp-Source: ABdhPJyCzEXS/CjHXhyPsWMJqSys0t+S6V0CILcgBrheHoAVd1X28DycdTMQiCI7UTHXXlQEhZcWRp02kibzFAZnjpc=
X-Received: by 2002:a25:8409:0:b0:63c:bea7:30af with SMTP id
 u9-20020a258409000000b0063cbea730afmr13740174ybk.633.1649442798030; Fri, 08
 Apr 2022 11:33:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Apr 2022 20:33:07 +0200
Message-ID: <CAJZ5v0g+31PFhkoROu18aT2CLGkn61v7aLgiPC3M_zbqqf_yCg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.18-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.18-rc2

with top-most commit 87ad236001eb95cf1760ccaf7670c94722231097

 Merge branch 'acpi-bus'

on top of commit 3123109284176b1532874591f7c81f3837bbdc17

 Linux 5.18-rc1

to receive ACPI updates for 5.18-rc2.

These revert a problematic commit from the 5.17 development cycle
and finalize the elimination of acpi_bus_get_device() that mostly
took place during the recent merge window.

Specifics:

 - Revert an ACPI processor driver change related to cache
   invalidation in acpi_idle_play_dead() that clearly was a mistake
   and introduced user-visible regressions (Akihiko Odaki).

 - Replace the last instance of acpi_bus_get_device() added during
   the recent merge window and drop the function to prevent more
   users of it from being added (Rafael Wysocki).

Thanks!


---------------

Akihiko Odaki (1):
      Revert "ACPI: processor: idle: Only flush cache on entering C3"

Rafael J. Wysocki (1):
      ACPI: bus: Eliminate acpi_bus_get_device()

---------------

 drivers/acpi/processor_idle.c |  3 +--
 drivers/acpi/scan.c           | 13 -------------
 drivers/spi/spi.c             |  3 ++-
 include/acpi/acpi_bus.h       |  1 -
 4 files changed, 3 insertions(+), 17 deletions(-)
